# VARIABLES

variable "https" {
	default = false
}

variable "https_secure" {
	default = false
}

# RESOURCES

resource "aws_security_group" "https" {
	count		= "${ var.https }"

	name		= "HTTPS"
	description = "Allow all HTTPS inbound traffic"

	ingress {
		from_port	= 443
		to_port		= 443
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

resource "aws_security_group" "https_secure" {
	count		= "${ var.https_secure }"

	name		= "HTTPS Secure"
	description = "Allow HTTPS inbound traffic from only instances within the VPC"

	ingress {
		from_port	= 443
		to_port		= 443
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

output "security_group_id_https" {
	value =	"${ aws_security_group.https.id }"
}

output "security_group_id_https_secure" {
	value =	"${ aws_security_group.https_secure.id }"
}

