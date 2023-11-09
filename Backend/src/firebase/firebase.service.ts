/* eslint-disable @typescript-eslint/no-var-requires */
import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { applicationDefault } from 'firebase-admin/app';

@Injectable()
export class FirebaseService {
  private admin;

  constructor() {

    admin.initializeApp({
      credential: applicationDefault(),
    });


    this.admin = admin;
  }

  getAuth() {
    return this.admin.auth();
  }
}
