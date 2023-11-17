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
import { Request, Response } from 'express';
import registerDto from './dto/registerUser.dto';
import { LocalAuthGuard } from './guards/local.guard';
import { JwtAuthGuard } from './guards/jwt.guard';
import { User } from 'src/user/entities/user.entity';
import { RefreshTokenGuard } from './guards/refreshToken.guard';
import requestWithUser from './interface/requestWithUser.interface';

@UseInterceptors(ClassSerializerInterceptor)
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Post('register')
  async register(@Body() registrationData: registerDto) {
    return await this.authService.register(registrationData);
  }

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async logIn(@Req() req: requestWithUser) {
    const { user } = req;
    const token = await this.authService.getTokens(
      user.id.toString(),
      user.username,
    );
    return token;
  }

  @UseGuards(JwtAuthGuard)
  @Get('profile')
  async signIn(@Req() req: Request) {
    const user = req.user;
    return user;
  }

  @UseGuards(RefreshTokenGuard)
  @Post('refresh-token')
  async refreshToken(@Req() req: requestWithUser) {
    const { user } = req;
    const token = await this.authService.getTokens(user.sub, user.username);
    return token;
  }
}
