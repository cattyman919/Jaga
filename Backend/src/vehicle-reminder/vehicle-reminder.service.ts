import { Injectable } from '@nestjs/common';
import { CreateVehicleReminderDto } from './dto/create-vehicle-reminder.dto';
import { UpdateVehicleReminderDto } from './dto/update-vehicle-reminder.dto';

@Injectable()
export class VehicleReminderService {
  create(createVehicleReminderDto: CreateVehicleReminderDto) {
    return 'This action adds a new vehicleReminder';
  }

  findAll() {
    return `This action returns all vehicleReminder`;
  }

  findOne(id: number) {
    return `This action returns a #${id} vehicleReminder`;
  }

  update(id: number, updateVehicleReminderDto: UpdateVehicleReminderDto) {
    return `This action updates a #${id} vehicleReminder`;
  }

  remove(id: number) {
    return `This action removes a #${id} vehicleReminder`;
  }
}
