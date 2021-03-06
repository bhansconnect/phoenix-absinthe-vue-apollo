import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import Vue from 'vue'
import 'vueify/lib/insert-css'
import {
    ApolloClient
} from 'apollo-client'
import {
    HttpLink
} from 'apollo-link-http'
import {
    InMemoryCache
} from 'apollo-cache-inmemory'
import VueApollo from 'vue-apollo'
import App from '@/App.vue'
import router from '@/router'

// install the vue plugin
Vue.use(VueApollo)

const httpLink = new HttpLink({
    // URL to graphql server, you should use an absolute URL here
    uri: 'http://localhost:4000/api'
})

const authLink = setContext((_, {
    headers
}) => {
    // get the authentication token from localstorage if it exists
    const token = localStorage.getItem('blog-app-token')

    // return the headers to the context so httpLink can read them
    return {
        headers: {
            ...headers,
            authorization: token ? `Bearer ${token}` : null
        }
    }
})

// update apollo client as below
const apolloClient = new ApolloClient({
    link: authLink.concat(httpLink),
    cache: new InMemoryCache()
})

const apolloProvider = new VueApollo({
    defaultClient: apolloClient
})

// update Vue instance by adding `apolloProvider`
new Vue({
    el: '#app',
    router,
    apolloProvider,
    template: '<App/>',
    components: {
        App
    }
})

import {
    setContext
} from 'apollo-link-context'