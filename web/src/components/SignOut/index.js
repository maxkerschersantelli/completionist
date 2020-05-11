import React from 'react';
import { useHistory } from 'react-router-dom';

import * as ROUTES from '../../constants/routes';
import { withFirebase } from '../Firebase';

const SignOutButton = ( {firebase} ) => {
	let history = useHistory();
	return (<button type="button" onClick={() => {
		history.push(ROUTES.LANDING);
		return firebase.signOut();
	}}>
		Sign Out
	</button>
	);
};



export default withFirebase(SignOutButton);