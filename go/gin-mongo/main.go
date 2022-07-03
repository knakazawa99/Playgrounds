package main 

import (
	"smartannotator/app/routes"
)

func main() {
	router := routes.Router()
    router.Run(":9001")
}