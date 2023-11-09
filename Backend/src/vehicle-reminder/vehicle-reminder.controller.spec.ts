import { Test, TestingModule } from '@nestjs/testing';
import { VehicleReminderController } from './vehicle-reminder.controller';
import { VehicleReminderService } from './vehicle-reminder.service';

describe('VehicleReminderController', () => {
  let controller: VehicleReminderController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [VehicleReminderController],
      providers: [VehicleReminderService],
    }).compile();

    controller = module.get<VehicleReminderController>(
      VehicleReminderController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
