import app from 'firebase/app';
import 'firebase/auth';

const config = {
	apiKey: process.env.REACT_APP_API_KEY,
    authDomain: process.env.REACT_APP_AUTH_DOMAIN,
    databaseURL: process.env.REACT_APP_DATABASE_URL,
    projectId: process.env.REACT_APP_PROJECT_ID,
    storageBucket: process.env.REACT_APP_STORAGE_BUCKET,
    messagingSenderId: process.env.REACT_APP_MESSAGING_SENDER_ID,
    appId: process.env.REACT_APP_APP_ID
};

class Firebase {
	constructor() {
		app.initializeApp(config);

        this.auth = app.auth();
        this.db = app.database();
	}

    // User API

    user = uid => this.db.ref(`users/${uid}`);

    users = () => this.db.ref('users');

    // Auth

    createUser = (email, password) => {
        const url = 
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" 
            + process.env.REACT_APP_API_KEY;
            
        return fetch(url, {
            method: "post",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                password: password,
                returnSecureToken: true
            })
        })
    };
    
    signIn = (email, password) =>
        this.auth.signInWithEmailAndPassword(email, password);

    signOut = () => {
        return this.auth.signOut();
    };

    resetPassword = email => this.auth.sendPasswordResetEmail(email);

    changePassword = password =>
        this.auth.currentUser.updatePassword(password);

    

}

export default Firebase;