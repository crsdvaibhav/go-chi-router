package main

import (
	"fmt"
	"net/http"
	"os"
)

type Config struct{
	Port string
}

type Application struct{
	Config Config
}

//GLOBALs
var port=os.Getenv("PORT")

func (app *Application) Serve() error {
	
	//Serve on the port
	srv:=&http.Server{
		Addr: fmt.Sprintf(":%s", port), //Address of server
	}

	//Return any errors
	return srv.ListenAndServe()
}

func main(){

	//Config
	var cfg Config
	cfg.Port = port

	dsn:=os.Getenv("DSN")
}