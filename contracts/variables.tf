variable "name" {
  type = string
  default = "default-filter"
}

variable "ether_t" {
  type = string                                
  default = "ip"                    
}

variable "prot" {
  type = string                                
  default = "tcp"
}

variable "d_from_port" {
  type = string                                
}

variable "d_to_port" {
  type = string
}

variable "stateful" {
  type = string
}
