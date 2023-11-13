import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request } from 'express'
import { AuthGuard } from '@nestjs/passport';
import RequestWithUser from './interface/requestWithUser.interface';
// import { LocalAuthGuard } from './guards/local.guard';
// import { JwtAuthGuard } from './guards/jwt.guard';
import registerDto from './dto/registerUser.dto';
import { AuthenticationGuard } from './guards/authenticated.guard';
import { LocalAuthGuard } from './guards/local.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }
  @Post('register')
  async register(@Body() registrationData: registerDto) {
    return await this.authService.register(registrationData);
  }

  //@UseGuards(LocalAuthenticationGuard)
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async logIn(@Req() req: Request) {
    const user = req.user;
    // const cookie: string = this.authenticationService.getCookieWithJwtToken(
    //   user.id,
    // );
    // request.res.setHeader('Set-Cookie', cookie);
    return user;
  }

  @UseGuards(AuthenticationGuard)
  @Get('profile')
  async signIn(@Req() req: Request) {
    const user = req.user;
    // const cookie: string = this.authenticationService.getCookieWithJwtToken(
    //   user.id,
    // );
    // request.res.setHeader('Set-Cookie', cookie);
    return user;
  }

  // @Post('log-out')
  // @UseGuards(JwtAuthenticationGuard)
  // async logOut(@Req() request: RequestWithUser, @Res() response: Response) {
  //   response.setHeader(
  //     'Set-Cookie',
  //     this.authenticationService.getCookieForLogOut(),
  //   );
  //   return response.sendStatus(200);
  // }

  // @Get()
  // @UseGuards(JwtAuthenticationGuard)
  // authenticate(@Req() request: RequestWithUser) {
  //   const user = request.user;
  //   user.password = undefined;
  //   return user;
  // }
}
