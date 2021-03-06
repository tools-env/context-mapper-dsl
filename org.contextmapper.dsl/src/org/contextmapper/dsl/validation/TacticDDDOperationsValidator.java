/*
 * Copyright 2020 The Context Mapper Project Team
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
package org.contextmapper.dsl.validation;

import static org.contextmapper.dsl.validation.ValidationMessages.STATE_VALUE_DOES_NOT_BELONG_TO_AGGREGATE;

import java.util.Set;
import java.util.stream.Collectors;

import org.contextmapper.dsl.cml.CMLModelObjectsResolvingHelper;
import org.contextmapper.dsl.contextMappingDSL.Aggregate;
import org.contextmapper.dsl.contextMappingDSL.ContextMappingModel;
import org.contextmapper.tactic.dsl.tacticdsl.DomainObjectOperation;
import org.contextmapper.tactic.dsl.tacticdsl.EnumValue;
import org.contextmapper.tactic.dsl.tacticdsl.ServiceOperation;
import org.contextmapper.tactic.dsl.tacticdsl.StateTransition;
import org.contextmapper.tactic.dsl.tacticdsl.TacticdslPackage;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.validation.AbstractDeclarativeValidator;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.validation.EValidatorRegistrar;

public class TacticDDDOperationsValidator extends AbstractDeclarativeValidator {

	@Override
	public void register(EValidatorRegistrar registrar) {
		// not needed for classes used as ComposedCheck
	}

	@Check
	public void createErrorIfServiceOperationStateTransitionContainsInvalidState(final ServiceOperation operation) {
		validateOperationStates(operation, operation.getStateTransition());
	}

	@Check
	public void createErrorIfDomainObjectOperationStateTransitionContainsInvalidState(final DomainObjectOperation operation) {
		validateOperationStates(operation, operation.getStateTransition());
	}

	private void validateOperationStates(EObject operation, StateTransition stateTransition) {
		if (stateTransition == null)
			return;

		CMLModelObjectsResolvingHelper helper = new CMLModelObjectsResolvingHelper((ContextMappingModel) EcoreUtil2.getRootContainer(operation));
		Aggregate aggregate = helper.resolveAggregate(operation);

		if (aggregate == null)
			return;

		Set<String> aggregateStates = helper.resolveAggregateStates(aggregate);
		for (EnumValue value : stateTransition.getFrom()) {
			if (!aggregateStates.contains(value.getName()))
				error(String.format(STATE_VALUE_DOES_NOT_BELONG_TO_AGGREGATE, value.getName(), aggregate.getName()), stateTransition,
						TacticdslPackage.Literals.STATE_TRANSITION__FROM, stateTransition.getFrom().indexOf(value));
		}

		for (EnumValue value : stateTransition.getTarget().getTo().stream().map(s -> s.getValue()).collect(Collectors.toList())) {
			if (!aggregateStates.contains(value.getName()))
				error(String.format(STATE_VALUE_DOES_NOT_BELONG_TO_AGGREGATE, value.getName(), aggregate.getName()), stateTransition.getTarget(),
						TacticdslPackage.Literals.STATE_TRANSITION_TARGET__TO, stateTransition.getTarget().getTo().indexOf(value));
		}
	}

}
