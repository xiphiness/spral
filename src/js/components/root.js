import React, { Component } from 'react';
import { BrowserRouter, Route } from "react-router-dom";
import classnames from 'classnames';
import _ from 'lodash';
import { HeaderBar } from "./lib/header-bar.js"
import { api } from '/api';
import { store } from '/store';

export class Root extends Component {
  constructor(props) {
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
    console.log('state', this.state)
  }

  render() {

    return (
      <BrowserRouter>
        <div>
        <HeaderBar/>
        <Route exact path="/~spral" render={ () => {
          return (
            <div className="pa3 w-100">
              <h1 className="mt0 f2">spral</h1>
              <p className="lh-copy measure pt3">Counter: {this.state.con}</p>
              <p className="lh-copy measure pt3">Foo: {4}</p>
              <button onClick={api.conInc}>Increase Counter</button>
              // <p className="lh-copy measure pt3">To get started, edit <code>src/index.js</code> or <code>spral.hoon</code> and <code>|commit %home</code> on your Urbit ship to see your changes.</p>
              // <a className="black no-underline db body-large pt3" href="https://urbit.org/docs">-> Read the docs</a>
            </div>
          )}}
        />
        </div>
      </BrowserRouter>
    )
  }
}
