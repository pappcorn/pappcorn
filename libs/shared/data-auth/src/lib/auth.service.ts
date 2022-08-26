import { Injectable, Optional } from '@angular/core';
import {
  Auth,
  authState,
  createUserWithEmailAndPassword,
  GoogleAuthProvider,
  signInAnonymously,
  signInWithEmailAndPassword,
  signInWithPopup,
  signOut,
  updateProfile,
  User,
} from '@angular/fire/auth';
import { EMPTY, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  public readonly user$: Observable<User | null> = EMPTY;
  constructor(@Optional() private auth: Auth) {
    if (this.auth) {
      this.user$ = authState(this.auth);
    }
  }
  async loginWithGoogle() {
    return await signInWithPopup(this.auth, new GoogleAuthProvider());
  }

  async loginAnonymously() {
    return await signInAnonymously(this.auth);
  }

  async logout() {
    return await signOut(this.auth);
  }

  async loginWithUserAndPassword(
    email: string | undefined,
    password: string | undefined
  ): Promise<void> {
    if (email && password) {
      signInWithEmailAndPassword(this.auth, email, password)
        .then((userCredential) => {
          console.log('✅ User logged in', userCredential);
        })
        .catch((error) => console.log('📛 Error logged in user', error));
    }
  }
  async createUserWithEmailAndPassword(
    email: string | undefined,
    password: string | undefined,
    name: string | undefined
  ): Promise<void> {
    if (email && password && name) {
      createUserWithEmailAndPassword(this.auth, email, password)
        .then((userCredential) => {
          console.log('✅ User created', userCredential);
          updateProfile(userCredential.user, { displayName: name })
            .then(() => console.log('✅ User name updated'))
            .catch((error) =>
              console.log('📛 Error updating user name', error)
            );
        })
        .catch((error) => console.log('📛 Error creating user', error));
    }
  }
}
