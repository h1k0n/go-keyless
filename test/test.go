package main

import (
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/http"
)

func main() {
	client := &http.Client{Transport: &http.Transport{
		TLSClientConfig: &tls.Config{
			InsecureSkipVerify:     true,
			SessionTicketsDisabled: true,
		},
		DisableCompression: true,
	}}

	resp, err := client.Get("https://test.xxx.com:1443/hello")
	if err != nil {
		panic(err)
	}
	body, _ := ioutil.ReadAll(resp.Body)
	fmt.Println(string(body))
	fmt.Println(resp.Status)

	resp, err = client.Get("https://test.xxx.com:1443/hello")
	if err != nil {
		panic(err)
	}
	body, _ = ioutil.ReadAll(resp.Body)
	fmt.Println(string(body))
	fmt.Println(resp.Status)

}
