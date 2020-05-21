import React, { Component } from 'react';

import { withFirebase } from '../Firebase';

const INITIAL_STATE = {
	passwordOne: '',
	passwordTwo: '',
	showForm: false,
	success: false,
	error: null,
};

class PasswordChangeForm extends Component {
	constructor(props) {
		super(props);

		this.state = { ...INITIAL_STATE };
	}

	onSubmit = event => {
		const { passwordOne, error } = this.state;

		this.props.firebase
			.changePassword(passwordOne)
			.then(auth => {
				this.setState({ ...INITIAL_STATE, success:true});
			})
			.catch(error => {
				this.setState({error});
			});

		event.preventDefault();
	};

	onChange = event => {
		this.setState({ [event.target.name]: event.target.value });
	};

	render() {
		const { passwordOne, 
				passwordTwo, 
				showForm, 
				success, 
				error } = this.state;

		const isInvalid = 
			passwordOne !== passwordTwo || passwordOne === '';

		return (
			<div>
				<button onClick={() => {
					this.setState({showForm: !this.state.showForm,
								   success: false});
				}} type="button">
					Change Password
				</button>

				{showForm &&
					<form onSubmit={this.onSubmit}>
						<input
							name="passwordOne"
							value={passwordOne}
							onChange={this.onChange}
							type="password"
							placeholder="New Password"
						/>
						<input
							name="passwordTwo"
							value={passwordTwo}
							onChange={this.onChange}
							type="password"
							placeholder="Confirm New Password"
						/>
						<button disabled={isInvalid} type="submit">
							Save
						</button>
					</form>
				}

				{success &&
					<p>Success!</p>
				}

				{error && <p>{error.message}</p>}
			</div>
		)
	}
}

export default withFirebase(PasswordChangeForm);