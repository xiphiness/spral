import React, { Component } from "react";
import _ from "lodash";
import { BrowserRouter, Route } from "react-router-dom";
import classnames from "classnames";
import { HeaderBar } from "./lib/header-bar.js";
import { api } from "/api";
import { store } from "/store";
import { FileSystem } from "./filesystem";
import { Navbar } from "./navbar";

export class Root extends Component {
	constructor(props) {
		super(props);
		this.state = store.state;
		store.setStateHandler(this.setState.bind(this));
		console.log("state", this.state);
	}

	render() {
		return (
			<BrowserRouter>
				<div className="mainpage">
					<div>
						<Navbar />
					</div>
					<div className="pagefeed">
						{/* <HeaderBar /> */}
						<Route
							path="/~spral"
							render={props => {
								const pathname = _.get(props, "location.pathname", false);

								return (
									<div className="pa3 w-100">
										<h1 className="mt0 f2">spral</h1>
										//{" "}
										<p className="lh-copy measure pt3">
											Counter: {this.state.con}
										</p>
										// <button onClick={api.conInc}>Increase Counter</button>
										//{" "}
										<p className="lh-copy measure pt3">
											To get started, edit <code>src/index.js</code> or{" "}
											<code>spral.hoon</code> and <code>|commit %home</code> on
											your Urbit ship to see your changes.
										</p>
										//{" "}
										<a
											className="black no-underline db body-large pt3"
											href="https://urbit.org/docs"
										>
											-> Read the docs
										</a>
										<FileSystem pathname={pathname} />
									</div>
								);
							}}
						/>
					</div>
				</div>
			</BrowserRouter>
		);
	}
}
