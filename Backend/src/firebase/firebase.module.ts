import { Module } from '@nestjs/common';
import { FirebaseService } from './firebase.service';
import { FirebaseController } from './firebase.controller';
import { FirebaseModule } from 'nestjs-firebase';
@Module({
  imports: [
    // FirebaseModule.forRoot({
    //   googleApplicationCredential: 'path/to/credential file.json',
    // }),
  ],
  controllers: [FirebaseController],
  providers: [FirebaseService],
})
export class FireBaseModule {}
