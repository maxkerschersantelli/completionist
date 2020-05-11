import React, { Component } from 'react';
import { Link } from 'react-router-dom';

import * as ROUTES from '../../constants/routes';
import { withFirebase } from '../Firebase';

const PasswordForgetPage = () => (
  <div>
    <h1>PasswordForget</h1>
    <PasswordForgetForm />
  </div>
);

const INITIAL_STATE = {
	email: '',
	sent: false,
	error: null,
};

class PasswordForgetFormBase extends Component {
	constructor(props) {
		super(props);

		this.state = { ...INITIAL_STATE };
	}

	onSubmit = event => {
		const { email } = this.state;

		this.props.firebase
			.resetPassword(email)
			.then(() => {
				this.setState({ ...INITIAL_STATE, sent:true });
			})
			.catch(error => {
				this.setState({error});
			});

		event.preventDefault();
	};

	onChange = event => {
		this.setState({ [event.target.name] : event.target.value });
	};

	render() {
		const { email, sent, error } = this.state;

		const isInvalid = email === '';

		return (
			<form onSubmit={this.onSubmit}>
				<input
					name="email"
					value={email}
					onChange={this.onChange}
					type="text"
					placeholder="Email Address"
				/>
				<button disabled={isInvalid} type="submit">
					Reset My Password
				</button>

				{sent && <p>Reset link sent</p>}
				{error && <p>{error.message}</p>}
			</form>
		);
	}
}

const PasswordForgetLink = () => (
	<p>
		<Link to={ROUTES.PASSWORD_FORGET}>Forgot Password?</Link>
	</p>
);

const PasswordForgetForm = withFirebase(PasswordForgetFormBase);

export default PasswordForgetPage;

export { PasswordForgetLink };