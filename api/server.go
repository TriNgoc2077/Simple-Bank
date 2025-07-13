package api

import (
	db "github.com/TriNgoc2077/Simple-Bank/db/sqlc"
	"github.com/gin-gonic/gin"
)

//server services HTTP request for our balancing service.
type Server struct {
	store *db.Store
	router *gin.Engine
}

//NewServer creates a new HTTP server and setup routing.
func NewServer(store *db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)
	router.GET("/accounts", server.listAccount)


	server.router = router
	return server
}

//start runs the HTTP server on a specific address.
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}