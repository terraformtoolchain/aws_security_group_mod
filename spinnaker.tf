# VARIABLES

variable "spinnaker" {
	default = false
}

variable "spinnaker_secure" {
	default = false
}

# RESOURCES

resource "aws_security_group" "spinnaker" {
	count		= "${ var.spinnaker }"

	name		= "Spinnaker"
	description = "Enables inbound Spinnaker components default ports"

	# Deck
	ingress {
		from_port	= 9000
		to_port		= 9000
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Gate
	ingress {
		from_port	= 8084
		to_port		= 8084
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Orca
	ingress {
		from_port	= 8083
		to_port		= 8083
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Clouddriver
	ingress {
		from_port	= 7002
		to_port		= 7002
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Rosco
	ingress {
		from_port	= 8087
		to_port		= 8087
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Front50
	ingress {
		from_port	= 8080
		to_port		= 8080
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Igor
	ingress {
		from_port	= 8088
		to_port		= 8088
		protocol	= "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	# Echo
	ingress {
		from_port	= 8089
		to_port		= 8089
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

resource "aws_security_group" "spinnaker_secure" {
	count		= "${ var.spinnaker_secure }"

	name		= "Spinnaker"
	description = "Enables inbound traffic for Spinnaker components default ports from only instances within the VPC"

	# Deck
	ingress {
		from_port	= 9000
		to_port		= 9000
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Gate
	ingress {
		from_port	= 8084
		to_port		= 8084
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Orca
	ingress {
		from_port	= 8083
		to_port		= 8083
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	#Clouddriver
	ingress {
		from_port	= 7002
		to_port		= 7002
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Rosco
	ingress {
		from_port	= 8087
		to_port		= 8087
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Front50
	ingress {
		from_port	= 8080
		to_port		= 8080
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Igor
	ingress {
		from_port	= 8088
		to_port		= 8088
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}

	# Echo
	ingress {
		from_port	= 8089
		to_port		= 8089
		protocol	= "tcp"
		cidr_blocks = [ "${ var.vpc_cidr }" ]
	}


	egress {
		from_port	= 0
		to_port		= 0
		protocol	= "-1"
		cidr_block	= [ "0.0.0.0/0" ]
	}
}

# OUTPUTS

output "security_group_id_spinnaker" {
	value =	"${ aws_security_group.https.id }"
}

output "security_group_id_spinnaker_secure" {
	value =	"${ aws_security_group.https_secure.id }"
}

