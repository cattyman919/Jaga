import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { VehicleReminderModule } from './vehicle-reminder/vehicle-reminder.module';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { FireBaseModule } from './firebase/firebase.module';

@Module({
  imports: [VehicleReminderModule, UserModule, AuthModule, FireBaseModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
