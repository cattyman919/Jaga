import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
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
  ) {}

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
      //   const tokens = await this.getTokens(user._id, user.username);
      //   await this.updateRefreshToken(user._id, tokens.refreshToken);
      //   return tokens;
      console.log(user);
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

  //   async updateRefreshToken(userId: string, refreshToken: string) {
  //     const hashedRefreshToken = await this.hashData(refreshToken);
  //     await this.userService.update(userId, {
  //       refreshToken: hashedRefreshToken,
  //     });
  //   }

  //   hashData(data: string) {
  //     return bcrypt.hash(data, 10);
  //   }

  async getTokens(userId: string, username: string) {
    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(
        {
          sub: userId,
          username,
        },
        {
          secret: this.configService.get<string>('JWT_ACCESS_SECRET'),
          expiresIn: this.configService.get<string>(
            'JWT_ACCESS_EXPIRATION_TIME',
          ),
        },
      ),
      this.jwtService.signAsync(
        {
          sub: userId,
          username,
        },
        {
          secret: this.configService.get<string>('JWT_REFRESH_SECRET'),
          expiresIn: this.configService.get<string>(
            'JWT_REFRESH_EXPIRATION_TIME',
          ),
        },
      ),
    ]);

    return {
      accessToken,
      refreshToken,
    };
  }
}
