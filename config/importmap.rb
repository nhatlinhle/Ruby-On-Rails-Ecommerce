# Pin npm packages by running ./bin/importmap

# Frontend
pin "application"
pin_all_from "app/javascript/controllers", under: "controllers"

# Admin
pin "admin"
pin_all_from "app/javascript/controllers/admin", under: "controllers/admin"
