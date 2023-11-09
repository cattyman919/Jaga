import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';

@Injectable()
export class AuthService {
  constructor(private firebaseService: FirebaseService) { }

  async validateUser(token: string): Promise<any> {
    try {
      const decodedToken = await this.firebaseService.getAuth().verifyIdToken(token);
      if (!decodedToken) {
        throw new Error('Invalid token');
      }
      return decodedToken;
    } catch (error) {
      throw error;
    }
  }
}
