package routes

import (
	"smartannotator/app/controllers"

	"github.com/gin-gonic/gin"
)

func Router() *gin.Engine {
	router := gin.Default()

	router.GET("/ping", controllers.GetPing)

	usersPrefix := "/users"
	router.GET(usersPrefix+"/", controllers.GetUsers)
	router.GET(usersPrefix+"/:userId", controllers.GetUser)

	annotationsPrefix := "/annotations"
	router.GET(annotationsPrefix+"/", controllers.GetAnnotations)

	dbTestPrefix := "/mongodb"
	router.GET(dbTestPrefix+"/", controllers.ConnectDB)
	router.GET(dbTestPrefix+"/gets", controllers.GetDB)
	router.PUT(dbTestPrefix+"/update", controllers.UpdateDB)
	router.POST(dbTestPrefix+"/insert", controllers.InsertDB)

	return router
}
