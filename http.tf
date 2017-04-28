# VARIABLES

variable "http" {
	default = false
}

variable "http_secure" {
	default = false
}

# RESOURCES

resource "aws_security_group" "http" {
	count		= "${ var.http }"

	name		= "HTTP"
	description = "Allow all HTTP inbound traffic"

	ingress {
		from_port	= 80
		to_port		= 80
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

resource "aws_security_group" "http_secure" {
	count		= "${ var.http_secure }"

	name		= "HTTP"
	description = "Allow HTTP inbound traffic only from instances within the VPC"

	ingress {
		from_port	= 80
		to_port		= 80
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

output "security_group_id_http" {
	value =	"${ aws_security_group.http.id }"
}

output "security_group_id_http_secure" {
	value =	"${ aws_security_group.http_secure.id }"
}

