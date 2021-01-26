terraform {
	required_version = ">=0.13"
}

provider "azurerm" {
	version = "~> 2.35.0"
			features {}
}

provider "helm" {
	version = "~> 2.0.0"
			features {}
}

provider "null" {
	version = "~>3.0.0"
			features {}  
}