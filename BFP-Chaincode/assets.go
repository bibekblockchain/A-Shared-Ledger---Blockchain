package main

//goods struct
type goods struct {
	Name    		string 	`json:"name"`
	Description   	string 	`json:"description"`
	Quantity		string	`json:"quantity"`
	Price			int32	`json:"price"`
}

//bill struct 
type bill struct {
	ShippedGoods	[]goods	`json:"shippedGoods"`
	TotalPrice		int32	`json:"totalPrice"`
}