package controllers

import (
	// "net/http"

	"github.com/gin-gonic/gin"
)

func GetUsers(ctx *gin.Context) {

	ctx.JSON(200, gin.H{
		"message": "pong",
	})
}

func GetUser(ctx *gin.Context) {
	userId := ctx.Param("userId")
	hoge := ctx.Query("hoge")
	ctx.JSON(200, gin.H{
		"userId": userId,
		"hoge": hoge,
	})
}