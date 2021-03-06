/*
 * Copyright 2018 The Context Mapper Project Team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.contextmapper.servicecutter.dsl.ui.handler;

import org.contextmapper.dsl.generator.ServiceCutterUserRepresentationsJSONGenerator;
import org.contextmapper.dsl.ui.handler.AbstractGenerationHandler;
import org.eclipse.xtext.generator.IGenerator2;

import com.google.inject.Inject;

public class ServiceCutterUserRepresentationJSONGenerationHandler extends AbstractGenerationHandler {

	@Inject
	private ServiceCutterUserRepresentationsJSONGenerator generator;

	@Override
	protected IGenerator2 getGenerator() {
		return generator;
	}

}
