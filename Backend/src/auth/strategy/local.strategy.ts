import { Strategy } from 'passport-local';
import { AuthGuard, PassportStrategy } from '@nestjs/passport';
import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthService } from '../auth.service';
import { User } from 'src/user/entities/user.entity';
import { Request } from 'express';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private authService: AuthService) {
    super(
      {
        usernameField: 'email',
      }
    )
  }


  async validate(email: string, passwordLogin: string): Promise<any> {

    const user = await this.authService.getAuthenticatedUser(email, passwordLogin);
    const {password, access_token, ...rest} = user

    return rest;
  }

}
