import React, { Component, Fragment } from "react";
import _ from "lodash";
import { Link } from "react-router-dom";
import classnames from "classnames";
import { store } from "/store";

export class FileSystem extends Component {
	constructor(props) {
		super(props);
		this.state = store.state;
		store.setStateHandler(this.setState.bind(this));
		// store.setStateHandler(this.setState.bind(this));
	}

	render() {
		let deskKeys = this.props.pathname.split("/").slice(2);
		if (deskKeys[0] == "") {
			deskKeys = deskKeys.slice(1);
		}
		const loc =
			deskKeys[0] === "" || deskKeys.length < 1
				? "dir"
				: "dir.".concat(deskKeys.join(".dir.").concat(".dir"));
		const parloc =
			deskKeys[0] === "" || deskKeys.length < 2
				? deskKeys.length === 1
					? "dir"
					: ""
				: "dir.".concat(
						deskKeys
							.slice(0, deskKeys.length - 1)
							.join(".dir.")
							.concat(".dir")
				  );

		const siblings = _.get(this.state.hon, parloc, false);

		const dirObj = _.get(this.state.hon, loc, false);

		const backName = deskKeys[deskKeys.length - 2];
		const currName = deskKeys[deskKeys.length - 1];
		// for (let x=0, x > parents.length, x++;) {key -> (parents).map(key => <Link></Link>)}
		let parents = [...deskKeys];
		parents.unshift("~spral");
		parents.pop();
		console.log("parents", parents);
		function backPath(num) {
			var bp =
				deskKeys.length > 1 && num !== parents.length
					? "/~spral/" + deskKeys.slice(0, deskKeys.length - num).join("/")
					: "/~spral";
			return bp;
		}
		console.log("backpath", backPath);
		console.log("backname", backName);
		console.log("deskKeys", deskKeys);
		console.log("dirObj", dirObj);
		console.log("loc", loc);
		console.log("currName", currName);
		console.log("siblings", siblings);
		console.log("parloc", parloc);
		console.log("this.state.hon", this.state.hon);
		console.log("this.props.pathname", this.props.pathname);
		console.log(
			"dkweird",
			deskKeys.length > 0 ? "/~spral/" + deskKeys : "/~spral"
		);
		return (
			<React.Fragment>
				<section className="data">
					<div className="top">
						<div className="parents">
							<p>[[parent tree goes here]]</p>
							<p>
								Current path: {deskKeys.length > 0 ? deskKeys.join("/") : "/"}
							</p>
							{_.keys(parents).map(key => (
								<Link
									to={backPath(parents.length - key)}
									className={`ba br1 grow bg-navy washed-green parent`}
									//may break if two files in the same directory have the same name
								>
									<p key={key} className="lh-copy measure pt3">
										Directory: {parents[key]}
									</p>
								</Link>
							))}
						</div>
					</div>
					<div className="bottom">
						<div className="current-siblings">
							<p>[[sibling tree + current goes here]]</p>
							{_.keys(siblings).map(key =>
								key !== currName ? (
									<Link
										to={backPath(1) + "/" + key}
										className={`card ba br1 grow washed-green bg-navy fl w-20 sibling`}
										//may break if two files in the same directory have the same name
									>
										<p key={key} className="lh-copy measure pt3">
											Directory: {key}
										</p>
									</Link>
								) : (
									<div
										className={`card ba br1 grow washed-green bg-green fl w-20`}
										//may break if two files in the same directory have the same name
									>
										<p key={key} className="lh-copy measure pt3">
											Current Directory: {key}
										</p>
									</div>
								)
							)}
						</div>
						<div className="children">
							<p>[[children go here]]</p>

							{_.keys(dirObj).map(key => (
								<Link
									to={this.props.pathname + "/" + key}
									className="card ba br1 grow bg-navy washed-green fl w-20"
								>
									<p key={key} className="lh-copy measure pt3">
										Directory: {key}
									</p>
								</Link>
							))}
						</div>
					</div>
				</section>
			</React.Fragment>
		);
	}
}

export default FileSystem;
