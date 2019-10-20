/*
 * Copyright 2019 The Context Mapper Project Team
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
package org.contextmapper.dsl.refactoring;

import java.util.List;
import java.util.stream.Collectors;

import org.contextmapper.dsl.contextMappingDSL.SharedKernel;
import org.contextmapper.dsl.contextMappingDSL.SymmetricRelationship;

/**
 * 
 * AR: Extracts a Shared Kernel to a new Bounded Context and establishes
 * upstream-downstream relationships between the new and the existing two
 * Bounded Contexts.
 * 
 * @author Stefan Kapferer
 *
 */
public class ExtractSharedKernelRefactoring extends AbstractExtractSymmetricRelationshipRefactoring implements Refactoring {

	public ExtractSharedKernelRefactoring(String boundedContext1, String boundedContext2) {
		super(boundedContext1, boundedContext2);
	}

	@Override
	List<SymmetricRelationship> getMatchingRelationships() {
		return model.getMap().getRelationships().stream().filter(rel -> rel instanceof SharedKernel).map(rel -> (SharedKernel) rel)
				.filter(sk -> sk.getParticipant1().getName().equals(boundedContext1) && sk.getParticipant2().getName().equals(boundedContext2)).collect(Collectors.toList());
	}

	@Override
	String getRelationshipType() {
		return "SharedKernel";
	}

}
