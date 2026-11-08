location            = "centralus"
resource_group_name = "RG-UKB-CUS-HUB"
vnet_name           = "VNET-UKB-CUS-HUB"
vnet_address_space  = ["10.3.0.0/20"]
subnets = {
  SN-UKB-CUS-HUB-TAILSCALE = { address_prefixes = ["10.3.0.0/24"] }
}