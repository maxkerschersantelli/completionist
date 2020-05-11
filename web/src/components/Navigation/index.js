import React from 'react';
import { Link } from 'react-router-dom';

import * as ROUTES from '../../constants/routes';
import { AuthUserContext } from '../Session';
import SignOutButton from '../SignOut';

const Navigation = () => (
  <AuthUserContext.Consumer>
    {authUser => authUser ? <NavigationAuth /> : <NavigationNoAuth />}
  </AuthUserContext.Consumer>
);

const NavigationAuth = () => (
  <div>
  	<ul>
  		<li>
  			<Link to={ROUTES.HOME}>Home</Link>
  		</li>
  		<li>
  			<Link to={ROUTES.ACCOUNT}>Account</Link>
  		</li>
      <li>
        <SignOutButton />
      </li>
  	</ul>
  </div>
);

const NavigationNoAuth = () => (
  <div>
    <ul>
      <li>
        <Link to={ROUTES.SIGN_IN}>Sign In</Link>
      </li>
    </ul>
  </div>
);

export default Navigation;