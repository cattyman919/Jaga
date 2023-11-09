import { Module } from '@nestjs/common';
import { VehicleReminderService } from './vehicle-reminder.service';
import { VehicleReminderController } from './vehicle-reminder.controller';

@Module({
  controllers: [VehicleReminderController],
  providers: [VehicleReminderService],
})
export class VehicleReminderModule {}
