# Terraform with modules

In terraform the resources can be aggruped in modules that 
can share information between them via variable injeccion

For example, you can define a lambda module and a sns mmodule
where the sns module share a needed arn to lambda module, and 
that is better, lambda module can enforce that the existence
of this var as you can see in `main.tf`  and `lambda/vars.tf`
