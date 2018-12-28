package main

import (
	"crypto/tls"
	"fmt"
)

type GlobalSession struct {
	session map[string]*tls.ClientSessionState
}

func NewGlobalSession() *GlobalSession {
	return &GlobalSession{
		session: make(map[string]*tls.ClientSessionState, 10000),
	}
}

func (p *GlobalSession) Get(sessionKey string) (session *tls.ClientSessionState, ok bool) {
	fmt.Println("GlobalSession get: ", sessionKey)

	session, ok = p.session[string(sessionKey)]

	return
}

// Put adds the ClientClientSessionState to the cache with the given key.
func (p *GlobalSession) Put(sessionKey string, sess *tls.ClientSessionState) {
	fmt.Printf("GlobalSession put: '%v'\n%#v", sessionKey, sess)

	p.session[string(sessionKey)] = sess
}
