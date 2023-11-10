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
import { AuthGuard } from '@nestjs/passport';
import RequestWithUser from './interface/requestWithUser.interface';
import { LocalAuthGuard } from './local.guard';
import { JwtAuthGuard } from './jwt.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  // @Post('register')
  // async register(@Body() registrationData: registerDto) {
  //   return await this.authenticationService.register(registrationData);
  // }

  //@UseGuards(LocalAuthenticationGuard)
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async logIn(@Req() req: RequestWithUser) {
    const { user } = req;
    // const cookie: string = this.authenticationService.getCookieWithJwtToken(
    //   user.id,
    // );
    // request.res.setHeader('Set-Cookie', cookie);
    return this.authService.login(user);
  }

  @UseGuards(JwtAuthGuard)
  @Get('profile')
  async signIn(@Req() req: RequestWithUser) {
    const { user } = req;
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
