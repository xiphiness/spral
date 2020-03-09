import React, { Component } from "react";

export class Navbar extends Component {
	render() {
		return (
			<div className="navbar">
				<ul className="navbar-nav">
					<li className="nav-item">
						<a href="#" className="nav-link">
							<i class="fas fa-biohazard fa-5x"></i>
						</a>
						<span className="link-text">Create Card</span>
					</li>
				</ul>
			</div>
		);
	}
}

export default Navbar;
