package controllers

import (
	"context"
	"fmt"
	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"smartannotator/pkg/db"
)

func ConnectDB(ctx *gin.Context) {
	dbContext, connection := db.ConnectDB()
	defer db.CloseDB(dbContext, connection)
	ctx.JSON(200, gin.H{
		"message": "pong",
	})
}

func GetDB(ctx *gin.Context) {
	result := getDB()
	ctx.JSON(200, gin.H{
		"message": "pong",
		"result":  result,
	})
}

func InsertDB(ctx *gin.Context) {
	//name := ctx.Query("name")
	name := ctx.PostForm("name")
	result := insertDB(name)
	ctx.JSON(200, gin.H{
		"message": "pong",
		"result":  result,
	})
}

func UpdateDB(ctx *gin.Context) {
	name := ctx.PostForm("name")
	result := updateDB(name)
	ctx.JSON(200, gin.H{
		"message": "pong",
		"result":  result,
	})
}

type dataType struct {
	Name    string `bson:"name"`
	Keyword string `bson:"keyword"`
}

func getDB() dataType {
	ctx, connection := db.ConnectDB()
	defer db.CloseDB(ctx, connection)

	// 結果を格納する変数を宣言
	var result dataType
	// MongoDBのCollectionを取得
	objectID, _ := primitive.ObjectIDFromHex("62c1036de325c418accd2d93")
	col := connection.Database("test").Collection("hoge")

	// 検索を実行し、結果を変数 result に格納
	err := col.FindOne(context.Background(), bson.M{"_id": objectID}).Decode(&result)
	_ = err
	fmt.Println(result)
	return result
}

func insertDB(name string) *mongo.InsertOneResult {
	ctx, connection := db.ConnectDB()
	defer db.CloseDB(ctx, connection)

	data := dataType{
		Name: name,
	}

	// MongoDBのCollectionを取得
	col := connection.Database("test").Collection("hoge")

	// データを挿入
	result, err := col.InsertOne(context.Background(), data)
	fmt.Println(result)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(result)
	return result
}

func updateDB(name string) *mongo.UpdateResult {
	ctx, connection := db.ConnectDB()
	defer db.CloseDB(ctx, connection)

	col := connection.Database("test").Collection("hoge")

	targetData := getDB()
	targetData.Keyword = targetData.Name + " -> " + name
	targetData.Name = name

	objectID, _ := primitive.ObjectIDFromHex("62c1036de325c418accd2d93")
	result, err := col.UpdateOne(
		context.Background(),
		bson.M{"_id": objectID},
		bson.M{"$set": targetData},
	)

	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(result)
	return result
}
