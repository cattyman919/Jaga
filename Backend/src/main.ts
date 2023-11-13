import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import session from 'express-session';
import passport from 'passport'
import { AuthenticationGuard } from './auth/guards/authenticated.guard';
import { ConfigService } from '@nestjs/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get<ConfigService>(ConfigService);

  app.useGlobalPipes(new ValidationPipe());
  app.use(session({
    secret: configService.get('COOKIE_SECRET'),
    name: "session",
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 3600000 }
  }))
  app.use(passport.initialize())
  app.use(passport.session())
  await app.listen(3000);
}
bootstrap();
