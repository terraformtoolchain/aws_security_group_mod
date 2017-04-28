# VARIABLES

variable "openvpn" {
	default = false
}

# RESOURCES

resource "aws_security_group" "openvpn" {
	count		= "${ var.openvpn }"

	name		= "OpenVPN"
	description = "Allow all OpenVPN inbound traffic"

	ingress {
		from_port	= 1194
		to_port		= 1194
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

# OUTPUTS

output "security_group_id_openvpn" {
	value =	"${ aws_security_group.openvpn.id }"
}
