import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { FirebaseService } from 'src/firebase/firebase.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService,
    private readonly firebaseService: FirebaseService
  ) { }

}
