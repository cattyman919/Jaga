import { PartialType } from '@nestjs/mapped-types';
import { CreateVehicleReminderDto } from './create-vehicle-reminder.dto';

export class UpdateVehicleReminderDto extends PartialType(CreateVehicleReminderDto) {}
