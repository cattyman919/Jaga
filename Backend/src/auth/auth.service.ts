import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
  Res
} from '@nestjs/common';
import { Response } from 'express'
import { JwtService } from '@nestjs/jwt';
import { User } from 'src/user/entities/user.entity';
import { UserService } from 'src/user/user.service';
import TokenPayload from './interface/payload.interface';
import * as bcrypt from 'bcrypt';
import { ConfigService } from '@nestjs/config';
import registerDto from './dto/registerUser.dto';
@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) { }

  public async register(registrationData: registerDto) {
    const hashedPassword = await bcrypt.hash(registrationData.password, 10);

    try {
      const createdUser = await this.userService.create({
        ...registrationData,
        password: hashedPassword,
      });

      return createdUser;
    } catch (error) {
      if (error?.code === '23505') {
        throw new HttpException(
          'User with that email or username already exist',
          HttpStatus.BAD_REQUEST,
        );
      }
      throw new HttpException(
        'Something went wrong with the server',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  public async getAuthenticatedUser(

    email: string,
    plainTextPassword: string,
  ): Promise<User> {
    try {
      const user = await this.userService.findOneByEmail(email);
      if (!user) throw new BadRequestException('User does not exist');
      await this.verifyPassword(plainTextPassword, user.password);
      // const userToken = await this.userService.getTokenUser(user.email)
      // if (userToken) {
      //   await this.jwtService.verifyAsync(userToken, { secret: this.configService.get<string>('JWT_ACCESS_SECRET') })
      //   return user
      // }
      const token = await this.getTokens(user.id.toString(), user.password)
      await this.userService.addTokenToUser(user.email, token)
      return user;
    } catch (error) {
      throw new HttpException(
        'Wrong credentials provided',
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  private async verifyPassword(
    plainTextPassword: string,
    hashedPassword: string,
  ) {
    const isPasswordMatching = await bcrypt.compare(
      plainTextPassword,
      hashedPassword,
    );
    if (!isPasswordMatching)
      throw new HttpException(
        'Wrong credentials provided',
        HttpStatus.BAD_REQUEST,
      );
  }



  hashData(data: string) {
    return bcrypt.hash(data, 10);
  }

  async getTokens(userId: string, username: string): Promise<string> {
    const payload = {
      sub: userId,
      username,
    }
    const accessToken = await this.jwtService.signAsync(
      payload,
      {
        secret: this.configService.get<string>('JWT_ACCESS_SECRET'),
        expiresIn: this.configService.get<string>(
          'JWT_ACCESS_EXPIRATION_TIME',
        ),
      },
    )

    return accessToken;
  }
}
