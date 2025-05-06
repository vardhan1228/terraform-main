resource "aws_key_pair" "name" {
    key_name = "publiccccc"
    public_key = file("~/.ssh/id_rsa.pub") #here you need to define public key file path

  
}


#A Terraform workspace is a way to manage multiple copies of the same infrastructure (e.g., dev, test, prod) using the same codebase.
# Subcommands:
#     delete    Delete a workspace
#     list      List Workspaces
#     new       Create a new workspace
#     select    Select a workspace
#     show      Show the name of the current workspace
# terraform workspace select dev
# terraform workspace list