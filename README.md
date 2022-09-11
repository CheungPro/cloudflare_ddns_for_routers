# cloudflare_ddns_for_routers
Cloudflare ddns script to update ip address dynamically for linux-based routers

# Guidance for this script

## STEP 1 : Create API with your cloudflare account

(https://dash.cloudflare.com/profile/api-tokens)[Click Here To Create Tokens]

## STEP 2 : connect your Router with SSH 

![image](https://user-images.githubusercontent.com/63193298/189516332-6ff0b657-68b5-4de4-9723-899370a323b6.png)



## STEP 3 : Push File into Router with a certain path

Actually, I'm poor in Linux, so I use vi to copy and paste, then save this file.
![image](https://user-images.githubusercontent.com/63193298/189516398-3a81bfef-6f08-452a-ba07-0542fe096e2f.png)


## STEP 4 : Set a Schedule Task
This may occur in "Advanced Settings" -> "Administration" -> "Services", remember to set a schedule to run it to update!
![image](https://user-images.githubusercontent.com/63193298/189516355-b6a78d4c-1512-4952-8b79-598480200494.png)
