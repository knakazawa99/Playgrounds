package db

import (
	"context"
	"fmt"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
	"time"
)

func ConnectDB() (context.Context, *mongo.Client) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	// 関数を抜けたらクローズするようにする
	defer cancel()
	// 指定したURIに接続する
	connection, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb://root:example@localhost:27017/"))

	err = connection.Ping(ctx, readpref.Primary())
	if err != nil {
		fmt.Println("connection error:", err)
	} else {
		fmt.Println("connection success:")
	}
	return ctx, connection
}

func CloseDB(ctx context.Context, connect *mongo.Client) {
	connect.Disconnect(ctx)
}
