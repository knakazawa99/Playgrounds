package controllers

import (
	"github.com/gin-gonic/gin"
)

func GetAnnotations(ctx *gin.Context) {
	ctx.JSON(200, gin.H{
		"message": "pong",
	})
}