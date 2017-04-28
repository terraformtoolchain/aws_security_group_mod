# VARIABLES

variable "postgres" {
	default = false
}

variable "postgres_secure" {
	default = false
}

# RESOURCES

resource "aws_security_group" "postgres" {
	count		= "${ var.postgres }"

	name		= "Postgres"
	description = "Allow all Postgres inbound traffic"

	ingress {
		from_port	= 5432
		to_port		= 5432
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

resource "aws_security_group" "postgres_secure" {
	count		= "${ var.postgres_secure }"

	name		= "Postgres Secure"
	description = "Allow Postgres inbound traffic from only instances within the VPC"

	ingress {
		from_port	= 5432
		to_port		= 5432
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

output "security_group_id_postgres" {
	value =	"${ aws_security_group.postgres.id }"
}

output "security_group_id_postgres_secure" {
	value =	"${ aws_security_group.postgres_secure.id }"
}

