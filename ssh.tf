# VARIABLES

variable "ssh" {
	default = false
}

variable "ssh_secure" {
	default = false
}

# RESOURCES

resource "aws_security_group" "ssh" {
	count		= "${ var.ssh }"

	name		= "SSH"
	description = "Allow all SSH inbound traffic"

	ingress {
		from_port	= 22
		to_port		= 22
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	egress {
		from_port	= 0
		to_port		= 0
		protocol	= "-1"
		cidr_blocks = [ "0.0.0.0/0" ]
	}
}

resource "aws_security_group" "ssh_secure" {
	count		= "${ var.ssh_secure }"

	name		= "SSH Secure"
	description = "Allow SSH inbound traffic from only instances within the VPC"

	ingress {
		from_port	= 22
		to_port		= 22
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	egress {
		from_port	= 0
		to_port		= 0
		protocol	= "-1"
		cidr_blocks = [ "0.0.0.0/0" ]
	}
}

# OUTPUTS

output "security_group_id_ssh" {
	value =	"${ aws_security_group.ssh.id }"
}

output "security_group_id_ssh_secure" {
	value =	"${ aws_security_group.ssh_secure.id }"
}

