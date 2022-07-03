package controllers

import (
	"context"
    "fmt"
    "time"

    "go.mongodb.org/mongo-driver/bson"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
    "go.mongodb.org/mongo-driver/mongo/readpref"
	"github.com/gin-gonic/gin"
)

func ConnectDB(ctx *gin.Context) {
	context, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	// 関数を抜けたらクローズするようにする
	defer cancel()
	// 指定したURIに接続する
	c, err := mongo.Connect(context, options.Client().ApplyURI("mongodb://localhost:27017"))
	defer c.Disconnect(context)
	// DBにPingする
	err = c.Ping(context, readpref.Primary())
	if err != nil {
		fmt.Println("connection error:", err)
	} else {
		fmt.Println("connection success:")
}
	ctx.JSON(200, gin.H{
		"message": "pong",
	})
}

func GetDB(ctx *gin.Context) {
	result := getDB()
	ctx.JSON(200, gin.H{
		"message": "pong",
		"result": result,
	})
}

func InsertDB(ctx *gin.Context) {
	insertDB()
	ctx.JSON(200, gin.H{
		"message": "pong",
	})
}

type resultType struct {
	Rid     string
	Keyword string
}

type dataType struct {
	Name     string `bson:"name"`
}

func getDB() resultType {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    c, _ := mongo.Connect(ctx, options.Client().ApplyURI("mongodb://localhost:27017"))
    defer c.Disconnect(ctx)

    // 結果を格納する変数の構造定義


    // 結果を格納する変数を宣言
    var result resultType

    // MongoDBのCollectionを取得
    col := c.Database("test").Collection("hoge")

    // 検索条件となるprimitive.ObjectID型の変数を指定
    // objectID, _ := primitive.ObjectIDFromHex("62c0e2959d0f13e5d425dde4")

    // 検索を実行し、結果を変数 result に格納
    err := col.FindOne(context.Background(), bson.M{"name": "test"}).Decode(&result)
    _ = err
    fmt.Println(result)
	return result 
}

func insertDB() {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()
    c, _ := mongo.Connect(ctx, options.Client().ApplyURI("mongodb://localhost:27017"))
    defer c.Disconnect(ctx)

    // 挿入するデータの構造を定義
    // 21, 22行目の末尾の文字はType aliasと呼ぶらしい。MongoDB内でフィールド名として解釈される
    type dataType struct {
        Name     string `bson:"name"`
        Keyword string `bson:"keyword"`
    }

    // 挿入するデータを作成
    data := dataType{
        Name:     "test2",
    }

    // MongoDBのCollectionを取得
    col := c.Database("test").Collection("hoge")

    // データを挿入
    col.InsertOne(context.Background(), data)	
}