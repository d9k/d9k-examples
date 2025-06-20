import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { SecondAppModule } from './second-app.module';

async function bootstrap() {
  const app = await NestFactory.create(SecondAppModule);

  const port = process.env.port ?? 3001;
  const logger = new Logger('bootstrap');
  logger.log(`Starting second app on port ${port}`);

  await app.listen(port);
}
bootstrap();
