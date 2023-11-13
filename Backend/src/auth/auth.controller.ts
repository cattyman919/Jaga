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
  ClassSerializerInterceptor,
  UseInterceptors,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request, Response } from 'express'
import registerDto from './dto/registerUser.dto';
import { AuthenticationGuard } from './guards/authenticated.guard';
import { LocalAuthGuard } from './guards/local.guard';

@UseInterceptors(ClassSerializerInterceptor)
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) { }
  @Post('register')
  async register(@Body() registrationData: registerDto) {
    return await this.authService.register(registrationData);
  }

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async logIn(@Req() req: Request) {
    const user = req.user;
    return user;
  }

  @UseGuards(AuthenticationGuard)
  @Get('profile')
  async signIn(@Req() req: Request) {
    const user = req.user;
    return user;
  }

  @UseGuards(AuthenticationGuard)
  @Post('logout')
  async logOut(@Req() req: Request) {
    req.session.destroy((err) => {
      return {
        message: "Something went wrong",
        error: err
      }
    })
    return {
      message: "Successfully Log Out",
      status: "OK"
    }
  }

}
